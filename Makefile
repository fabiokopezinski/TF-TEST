ifeq ($(OS),Windows_NT)
  ifeq ($(shell uname -s),) # not in a bash-like shell
	CLEANUP = del /F /Q
	MKDIR = mkdir
  else # in a bash-like shell, like msys
	CLEANUP = rm -f
	MKDIR = mkdir -p
  endif
	TARGET_EXTENSION=.exe
else
	CLEANUP = rm -f
	MKDIR = mkdir -p
	TARGET_EXTENSION=.out
endif

C_COMPILER=gcc
ifeq ($(shell uname -s), Darwin)
C_COMPILER=clang
endif

UNITY_ROOT=Unity

CFLAGS=-std=c99
CFLAGS += -Wall
CFLAGS += -Wextra
CFLAGS += -Wpointer-arith
CFLAGS += -Wcast-align
CFLAGS += -Wwrite-strings
CFLAGS += -Wswitch-default
CFLAGS += -Wunreachable-code
CFLAGS += -Winit-self
CFLAGS += -Wmissing-field-initializers
CFLAGS += -Wno-unknown-pragmas
CFLAGS += -Wstrict-prototypes
CFLAGS += -Wundef
CFLAGS += -Wold-style-definition

TARGET_BASE1=all_test
TARGET1 = $(TARGET_BASE1)$(TARGET_EXTENSION)
SRC_FILES1=\
  $(UNITY_ROOT)/src/unity.c \
  $(UNITY_ROOT)/extras/fixture/src/unity_fixture.c \
  identifier/src/identifier.c \
	identifier/test/TestFoo.c \
  identifier/test/test_runners/TestFoo_Runner.c \
  identifier/test/test_runners/all_test.c
INC_DIRS=-Isrc -I$(UNITY_ROOT)/src -I$(UNITY_ROOT)/extras/fixture/src
SYMBOLS=
all: clean cppcheck clean compile run clean compile cov clean compile valgrind


cppcheck:
	@echo "  "
	@echo "  "
	@echo "       CPPCHECK "
	@echo " "
	cppcheck identifier/src/identifier.c
	@echo " "


compile:
	$(C_COMPILER) $(CFLAGS) -fprofile-arcs -ftest-coverage $(INC_DIRS) $(SYMBOLS) $(SRC_FILES1) -o $(TARGET1)

run:
	@echo " "
	@echo "       TEST       " 
	@echo " "
	- ./$(TARGET1) -v
	
cov:
	@echo " "
	@echo "       COV          " 
	@echo " "
	- gcov -b -c identifier.c

valgrind:
	@echo "  "
	@echo "  "
	@echo "     VALGRIND       "
	@echo "  "
	- valgrind --leak-check=full --show-leak-kinds=all ./$(TARGET1) > valgrind.log


clean:
	$(CLEANUP) $(TARGET1)
	rm -fr $(ALL) *.o cov* *.dSYM *.gcda *.gcno *.gcov


ci: CFLAGS += -Werror 
ci: compile

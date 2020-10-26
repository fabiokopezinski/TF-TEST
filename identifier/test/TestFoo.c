#include "identifier.h"
#include "unity.h"
#include "unity_fixture.h"
#include <string.h>


TEST_GROUP(identifier);

TEST_SETUP(identifier){
}

TEST_TEAR_DOWN(identifier){
}
TEST(identifier, MinSize){
  char string[] = {"L"};
  TEST_ASSERT_EQUAL(0,identifier(string));
}

TEST(identifier, MaxSize){
  char string[] = {"letra6"};
  TEST_ASSERT_EQUAL(0,identifier(string));
}

TEST(identifier, Number){
  char string[] = {"2"};
  TEST_ASSERT_EQUAL(1,identifier(string));
}

TEST(identifier, Empty){
  char string[] = {""};
  TEST_ASSERT_EQUAL(1,identifier(string));
}

TEST(identifier, ThanMoreLimit){
  char string[] = {"letras7"};
  TEST_ASSERT_EQUAL(1,identifier(string));
}

TEST(identifier, IsNotCharNormal){
  char string[] = {"####"};
  TEST_ASSERT_EQUAL(1,identifier(string));
}
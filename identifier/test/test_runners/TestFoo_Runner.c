#include "unity.h"
#include "unity_fixture.h"

TEST_GROUP_RUNNER(identifier)
{

	RUN_TEST_CASE(identifier,MinSize)
	RUN_TEST_CASE(identifier, MaxSize)
	RUN_TEST_CASE(identifier,Number)
	RUN_TEST_CASE(identifier,Empty)
	RUN_TEST_CASE(identifier,ThanMoreLimit)
	RUN_TEST_CASE(identifier,IsNotCharNormal)
}
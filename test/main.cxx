#include <catch.hxx>

constexpr int N = 1 << 20;

TEST_CASE("i == i")
{
    for (int i = 0; i < N; ++i)
        CHECK( i == i );
}

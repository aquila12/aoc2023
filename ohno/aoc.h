/* AoC interface */

extern int null_implementation();

#define UNKNOWN (-69420)
#define NOIMPL null_implementation

struct aoc_part {
  int (*impl)();
  int answer;
  int runs;
};

struct aoc_day {
  union {
    struct aoc_part parts[2];
    struct {
      struct aoc_part part1;
      struct aoc_part part2;
    };
  };
};

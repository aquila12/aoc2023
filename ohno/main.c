/* Entry point */

#include "stdio.h"
#include "aoc.h"

int null_implementation() { return 0; };

extern struct aoc_day day1;


struct aoc_day* days[] = {
  &day1
};

void run_part(struct aoc_part *part) {
  if(part->impl) {
    printf("...");

    int answer = part->impl();

    printf("%d", answer);
    if(answer == part->answer) printf(" (correct)");
    else printf(" (should be %d)", part->answer);
  } else {
    printf(" - no implementation\n");
  }
}

int main() {
  size_t n_days = sizeof(days) / sizeof(days[0]);

  printf("AoC 2023\n");
  printf("%ld days\n\n", n_days);

  for(int d = 0; d < n_days; ++d) {
    for(int p = 0; p < 2; ++p) {
      printf("Run day %d part %d", d, p);
      run_part(&days[d]->parts[p]);
      printf("\n");
    }
  }
}

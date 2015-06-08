#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
#define MIN(a,b) (((a)<(b))?(a):(b))
#define MAX(a,b) (((a)>(b))?(a):(b))

# get filesize
FILE *f = fopen("file", "rb");
fseek(f, 0, SEEK_END);
int filesize = ftell(f);

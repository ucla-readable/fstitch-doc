/* fsync for programs that needn't fsync. */
int fsync(int fd)
{
	return 0;
}

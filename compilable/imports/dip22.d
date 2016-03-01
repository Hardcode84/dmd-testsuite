module imports.dip22;

interface Base1
{
    private ubyte bar() { return 1; }
    private enum baz = 1;
    private alias T = byte;
}

interface Base2
{
    final short bar() { return 2; }
    enum baz = 2;
    alias T = short;
}

void bar() {}
private void bar(int) {}

private void baz(int) {}
void baz() {}

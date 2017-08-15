// helper for mangling tests with back references

module imports.testmangle;

public import core.demangle : demangle, demangleType;

// detect mangle version
private
{
    struct Detect;
    Detect* detectMangle(Detect*);
}

pragma(msg,detectMangle.mangleof);
static if(detectMangle.mangleof == "_D7imports10testmangle12detectMangleFPSQL3H6DetectZQ1e")
    enum { BackRefs = true, BackRefSymbols = true }
else static if(detectMangle.mangleof == "_D7imports10testmangle12detectMangleFPSQ3HQ3C6DetectZQ1g")
    enum { BackRefs = true, BackRefSymbols = false }
else static if(detectMangle.mangleof == "_D7imports10testmangle12detectMangleFPS7imports10testmangle6DetectZPS7imports10testmangle6Detect")
    enum { BackRefs = false, BackRefSymbols = false }
else
    static assert(false, "unknown mangling");

pragma(msg,BackRefs);
pragma(msg,BackRefSymbols);

static if (BackRefs)
{
    string tl(string s)() { return null; }
    string id(string s, string r, string r2 = null)() { return BackRefSymbols && r2 !is null ? r2 : r; }
}
else
{
    string tl(string s)() { return s; }
    string id(string s, string r, string r2 = null)() { return s; }
}

bool equalDemangle(string m1, string m2)
{
    auto dm1 = demangle(m1);
    auto dm2 = demangle(m2);
    return dm1 == dm2;
}

string unsignedToString(ulong x)
{
    string s;
    s ~= cast(char)('0' + (x % 10));
    x /= 10;
    while (x > 0)
    {
        s = cast(char)('0' + (x % 10)) ~ s;
        x /= 10;
    }
    return s;
}

/*
REQUIRED_ARGS: -dip1000
PERMUTE_ARGS:
TEST_OUTPUT:
---
fail_compilation/retscope2.d(102): Error: scope variable s assigned to p with longer lifetime
fail_compilation/retscope2.d(107): Error: address of variable s assigned to p with longer lifetime
---
*/

#line 100
@safe foo1(ref char[] p, scope char[] s)
{
    p = s;
}

@safe bar1(ref char* p, char s)
{
    p = &s;
}

/**********************************************/

// https://issues.dlang.org/show_bug.cgi?id=17123

void test200()
{
    char[256] buffer;

    char[] delegate() read = () {
        return buffer[];
    };
}

/**********************************************/

/*
TEST_OUTPUT:
---
fail_compilation/retscope2.d(302): Error: scope variable a assigned to return scope b
---
*/

#line 300
@safe int* test300(scope int* a, return scope int* b)
{
    b = a;
    return b;
}

/**********************************************/

/*
TEST_OUTPUT:
---
fail_compilation/retscope2.d(403): Error: scope variable a assigned to return scope c
---
*/

#line 400
@safe int* test400(scope int* a, return scope int* b)
{
    auto c = b; // infers 'return scope' for 'c'
    c = a;
    return c;
}

/**********************************************/

/*
TEST_OUTPUT:
---
fail_compilation/retscope2.d(504): Error: scope variable c may not be returned
---
*/

#line 500
@safe int* test500(scope int* a, return scope int* b)
{
    scope c = b; // does not infer 'return' for 'c'
    c = a;
    return c;
}

/**********************************************/

/*
TEST_OUTPUT:
---
fail_compilation/retscope2.d(604): Error: scope variable _param_0 assigned to non-scope parameter unnamed calling retscope2.foo600
fail_compilation/retscope2.d(604): Error: scope variable _param_1 assigned to non-scope parameter unnamed calling retscope2.foo600
fail_compilation/retscope2.d(614): Error: template instance retscope2.test600!(int*, int*) error instantiating
---
*/

#line 600
@safe test600(A...)(scope A args)
{
    foreach (i, Arg; A)
    {
        foo600(args[i]);
    }
}

@safe void foo600(int*);

@safe bar600()
{
    scope int* p;
    scope int* q;
    test600(p, q);
}



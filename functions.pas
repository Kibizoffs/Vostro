unit Functions;

interface
    function f1(x: double): double;
    function f2(x: double): double;
    function f3(x: double): double;

implementation
    function f1(x: double): double;
    begin
        f1 := exp(-x) + 3
    end;

    function f2(x: double): double;
    begin
        f2 := 2*x - 2
    end;

    function f3(x: double): double;
    begin
        f3 := 1 / x
    end;
end.

unit Functions;

interface
    type
        fun_type = function(x: double): double;

    const
        sections: array[1..6] of double = (
            2, 3, {локализация корня для f1 и f2}
            0, 1, {локализация корня для f1 и f3}
            1, 2  {локализация корня для f2 и f3}
        );
    
    var
        fun_arr: array[1..3] of fun_type;

    procedure Set_fun_arr();

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

    procedure Set_fun_arr();
    begin
        fun_arr[1] := @f1;
        fun_arr[2] := @f2;
        fun_arr[3] := @f3;
    end;
end.

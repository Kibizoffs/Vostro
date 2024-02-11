unit Functions; {Мат. функции}

interface
    type
        fun_type = function(x: double): double;

    const
        sections: array[1..6] of double = (
            2, 3, {Локализация корня для f1 и f2}
            0, 1, {Локализация корня для f1 и f3}
            1, 2  {Локализация корня для f2 и f3}
        );
    
    var
        fun_arr: array[1..3] of fun_type;

    procedure Set_fun_arr();

implementation
    uses
        Math; {Стандартное}

    function F1(x: double): double;
    begin
        f1 := exp(-x) + 3
    end;

    function F2(x: double): double;
    begin
        f2 := 2*x - 2
    end;

    function F3(x: double): double;
    begin
        f3 := 1 / x
    end;

    procedure Set_fun_arr();
    begin
        fun_arr[1] := @F1;
        fun_arr[2] := @F2;
        fun_arr[3] := @F3;
    end;
end.

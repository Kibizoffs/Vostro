{
    Можно изменить
    - функции в F1, F2, F3
    - строки в F1_STR, F2_STR, F3_STR
    - неравенства в Inside
    - первообразные в P1, P2, P3
    - отрезки в SECTIONS
}

unit Functions; {Мат. функции}

interface
    type
        fun_type = function(x: double): double;
        fun_arr_type = record
            f: array[1..3] of fun_type;
            s: array[1..3] of string;
            p: array[1..3] of fun_type
        end; 

    const
        SECTIONS: array[1..6] of double = (
            2, 3, {Локализация корня для f1 и f2}
            0.1, 1, {Локализация корня для f1 и f3}
            1, 2  {Локализация корня для f2 и f3}
        );

        F1_STR = 'f1 = exp(-x) + 3';
        F2_STR = 'f2 = 2*x - 2';
        F3_STR = 'f3 = 1/x';

    var
        stop_when_undef: boolean;
        fun_arr: fun_arr_type;

    function F1(x: double): double;
    function F2(x: double): double;
    function F3(x: double): double;
    function Inside(x: double; y: double): boolean;
    procedure Set_fun_arr();

implementation
    uses
        Math,   {Стандартное}
        Output; {Вывод}

    function F1(x: double): double;
    begin
        {if x ... then
            if stop_when_undef then
                Write_err(ERR_BAD_NUM, '')
            else
                f1 := 1025
        else} f1 := exp(-x) + 3
    end;

    function F2(x: double): double;
    begin
        {if x ... then
            if stop_when_undef then
                Write_err(ERR_BAD_NUM, '')
            else
                f2 := 1025
        else} f2 := 2*x - 2
    end;

    function F3(x: double): double;
    begin
        if x = 0 then
            if stop_when_undef then
                Write_err(ERR_BAD_NUM, '')
            else
                f3 := 1025
        else f3 := 1 / x
    end;

    function Inside(x: double; y: double): boolean;
    begin
        if (y < F1(x)) and (y > F2(x)) and (y > F3(x)) then
            inside := true
        else
            inside := false
    end;

    function P1(x: double): double;
    begin
        {if x ... then
            Write_err(ERR_BAD_NUM, '')
        else} p1 := -1/exp(x) + 3*x
    end;

    function P2(x: double): double;
    begin
        {if x ... then
            Write_err(ERR_BAD_NUM, '')
        else} p2 := Power(x, 2) - 2*x
    end;
    
    function P3(x: double): double;
    begin
        {if x ... then
            Write_err(ERR_BAD_NUM, '')
        else} p3 := ln(abs(x))
    end;

    procedure Set_fun_arr();
    begin
        stop_when_undef := true;
        fun_arr.f[1] := @F1;
        fun_arr.f[2] := @F2;
        fun_arr.f[3] := @F3;
        fun_arr.s[1] := F1_STR;
        fun_arr.s[2] := F2_STR;
        fun_arr.s[3] := F3_STR;
        fun_arr.p[1] := @P1;
        fun_arr.p[2] := @P2;
        fun_arr.p[3] := @P3;
    end;
end.

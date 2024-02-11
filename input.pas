unit Input; {Обработка ввода}

interface     
    procedure Read_input();

implementation
    uses
        Global,        {Глобальное}
        GUI,           {Графика}
        Output;        {Вывод}

    procedure Check_eps(eps: double; s: string);
    begin
        if (eps <= 0) or (eps >= 1) then
            Write_err(ERR_BAD_PARAM, s);
    end;

    function Eps_str_to_dbl(eps_str: string; s: string): double;
    begin
        if eps_str[2] = ',' then
            eps_str[2] := '.';
        Val(eps_str, Eps_str_to_dbl, err_code);
        if err_code <> 0 then
            Write_err(ERR_BAD_PARAM, s);
        Check_eps(Eps_str_to_dbl, s)
    end;

    procedure Read_input();
    var
        eps_x_str, eps_s_str, scale_str: string;
    begin
        {Обработка параметров}
        if ParamCount > 3 then
            Write_err(ERR_TOO_MANY_PARAMS, '');
        {ParamStr(0) соответствует названию исполняемого файла}
        eps_x_str := ParamStr(1);
        Eps_str_to_dbl(eps_x_str, 'погрешность корней пересечения графиков');
        eps_s_str := ParamStr(2);
        Eps_str_to_dbl(eps_s_str, 'погрешность площади');
        scale_str := ParamStr(3); {???}

        Launch_window()
    end;
end.

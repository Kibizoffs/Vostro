{Обработка ввода}
unit Input;

interface
    var
        eps_x, eps_s, scale: double;
        
    procedure Read_input();

implementation
    uses
        Output; {Вывод}

    function Str_to_dbl(str: string; msg: string): double;
    var
        i: integer;
        err_code: byte;
    begin
        for i := 1 to Length(str) do
            if str[i] = ',' then
            begin
                str[i] := '.';
                break
            end;
        Val(str, str_to_dbl, err_code);
        if err_code <> 0 then
            Write_err(ERR_BAD_PARAM, msg)
        else if ((str_to_dbl <= 0) or (msg <> 'масштаб') and (str_to_dbl > 1)) then
            Write_err(ERR_BAD_PARAM, msg);
    end;

    procedure Read_input();
    var
        eps_x_str, eps_s_str, scale_str: string;
    begin
        Debug('Начало чтения и обработки входных данных');
        {Обработка параметров}
        if ParamCount > 3 then
            Write_err(ERR_TOO_MANY_PARAMS, '');
        {ParamStr(0) соответствует названию исполняемого файла}
        eps_x_str := ParamStr(1);
        eps_x := Str_to_dbl(eps_x_str, 'погрешность абсцисс пересечений графиков');
        eps_s_str := ParamStr(2);
        eps_s := Str_to_dbl(eps_s_str, 'погрешность площади');
        scale_str := ParamStr(3);
        scale := Str_to_dbl(scale_str, 'масштаб');
        Debug('Конец чтения и обработки входных данных');
    end;
end.

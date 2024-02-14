unit Input; {Обработка ввода}

interface
    var
        eps_x, eps_s, scale: double;
        
    procedure Read_input();

implementation
    uses
        Output; {Вывод}

    const
        MSG_X = 'погрешность абсцисс пересечений графиков';
        MSG_S = 'погрешность площади';
        MSG_SCALE = 'масштаб';

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
        else if ((msg <> 'масштаб') and ((str_to_dbl <= 0) or (str_to_dbl >= 1))) then
            Write_err(ERR_BAD_PARAM, msg);
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
        eps_x := Str_to_dbl(eps_x_str, MSG_X);
        eps_s_str := ParamStr(2);
        eps_s := Str_to_dbl(eps_s_str, MSG_S);
        scale_str := ParamStr(3);
        scale := Str_to_dbl(scale_str, MSG_SCALE);
    end;
end.

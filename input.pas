unit Input; {Обработка ввода}

interface
    var
        ini_audio, ini_debug, ini_desmos, ini_log: boolean;
        ini_theme: string;
        
    procedure Run();

implementation
    uses
        Crt, IniFiles, {Стандартное}
        Global,        {Глобальное}
        Output,        {Вывод}
        Utils;         {Дополнительное}

    procedure Check_eps(eps: double; s: string);
    begin
        if (eps <= 0) or (eps >= 1) then
            Write_err(ERR_BAD_PARAM, s);
    end;

    function Eps_str_to_dbl(eps_str: string; s: string): double;
    begin
        if eps_str[2] = ',' then
            eps_str[2] := '.';
        Val(eps_str, Eps_str_to_dbl, code);
        Check_eps(Eps_str_to_dbl, s)
    end;

    procedure Run();
    var
        eps_x_str, eps_s_str, scale_str: string;
        ini: TIniFile;
    begin
        {Подготовка терминала}
        ClrScr();
        NormVideo();

        {Конфигурация программы}
        ini := TIniFile.Create(CONFIG_PATH);
        if ini.ReadString('settings', 'audio', '0') = '1' then
            ini_audio := true;
        if ini.ReadString('settings', 'desmos', '0') = '1' then
            ini_desmos := true;
        if ini.ReadString('settings', 'log', '0') = '1' then
            ini_log := true;
        ini_theme := ini.ReadString('settings', 'theme', 'dark');
        if ini.ReadString('settings', 'debug', '0') = '1' then
        begin
            ini_debug := true;
            debug(MSG_AUDIO + Bool_to_str(ini_audio));
            debug(MSG_DEBUG + Bool_to_str(ini_debug));
            debug(MSG_DESMOS + Bool_to_str(ini_desmos));
            debug(MSG_LOG + Bool_to_str(ini_log));
            debug(MSG_THEME + ini_theme);
        end;

        {Обработка параметров}
        if ParamCount > 3 then
            Write_err(ERR_TOO_MANY_PARAMS, '');
        {ParamStr(0) соответствует названию исполняемого файла}
        eps_x_str := ParamStr(1);
        Eps_str_to_dbl(eps_x_str, 'погрешность корней пересечения графиков');
        eps_s_str := ParamStr(2);
        Eps_str_to_dbl(eps_s_str, 'погрешность площади');
        scale_str := ParamStr(3); {???}
    end;
end.

unit Config;

interface
    var
        ini_debug, ini_log: boolean;
        ini_theme: string;

    procedure Setup_ini();

implementation
    uses
        IniFiles, {Стандартное}
        Output;   {Вывод}
    
    const
        CONFIG_PATH = 'config.ini';

    var
        ini: TIniFile;

    function Bool_to_str(bool: boolean): string;
    begin
        if bool then
            bool_to_str := 'да'
        else
            bool_to_str := 'нет';
    end;

    procedure Setup_ini();
    begin
        ini := TIniFile.Create(CONFIG_PATH);
        if ini.ReadString('settings', 'log', '0') = '1' then
        begin
            ini_log := true;
            Prepare_output_file()
        end;
        if ini.ReadString('settings', 'debug', '0') = '1' then
        begin
            ini_debug := true;
            debug(MSG_DEBUG + Bool_to_str(ini_debug));
            debug(MSG_LOG + Bool_to_str(ini_log))
        end;
    end;
end.

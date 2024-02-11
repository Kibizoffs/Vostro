unit Config;

interface
    procedure Setup_ini();

implementation
    uses
        IniFiles, {стандартное}
        Global,   {глобальное}
        Utils,    {дополнительное}
        Output;   {вывод}
    
    const
        CONFIG_PATH = 'config.ini';

    var
        ini: TIniFile;

    procedure Setup_ini();
    begin
        ini := TIniFile.Create(CONFIG_PATH);
        if ini.ReadString('settings', 'log', '0') = '1' then
        begin
            ini_log := true;
            Prepare_output_file()
        end;
        ini_theme := ini.ReadString('settings', 'theme', 'dark');
        if ini.ReadString('settings', 'debug', '0') = '1' then
        begin
            ini_debug := true;
            debug(MSG_DEBUG + Bool_to_str(ini_debug));
            debug(MSG_LOG + Bool_to_str(ini_log));
            debug(MSG_THEME + '''' + ini_theme + '''');
        end;
    end;
end.

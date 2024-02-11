Program Vostro;

uses
    Cthreads,      {Стандартное (для работы PtcGraph)}
    Crt, IniFiles, {Стандартное}
    Global,        {Глобальное}
    Input,         {Обработка ввода}
    Output,        {Процесс вывода}
    Utils;         {Дополнительное}

const
    CONFIG_PATH = 'config.ini';

var
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
    begin
        ini_log := true;
        Prepare_output_file()
    end;
    ini_theme := ini.ReadString('settings', 'theme', 'dark');
    if ini.ReadString('settings', 'debug', '0') = '1' then
    begin
        ini_debug := true;
        debug(MSG_AUDIO + Bool_to_str(ini_audio));
        debug(MSG_DEBUG + Bool_to_str(ini_debug));
        debug(MSG_DESMOS + Bool_to_str(ini_desmos));
        debug(MSG_LOG + Bool_to_str(ini_log));
        debug(MSG_THEME + '''' + ini_theme + '''');
    end;

    Read_input();
end.

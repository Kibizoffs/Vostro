unit Global; {Глобальное}

interface
    const
        ERR_TOO_MANY_PARAMS = 'Слишком много параметров';
        ERR_BAD_PARAM = 'Плохой параметр: ';
        ERR_LOG_FILE = 'Возникла проблема с логинг файлом';
        MSG_AUDIO = 'Аудио = ';
        MSG_DEBUG = 'Отладка = ';
        MSG_DESMOS = 'Десмос = ';
        MSG_LOG = 'Логирование = ';
        MSG_THEME = 'Тема = ';
    var
        ini_audio, ini_debug, ini_desmos, ini_log: boolean;
        ini_theme: string;
        err_code: integer;
        output_file: text;

implementation

end.

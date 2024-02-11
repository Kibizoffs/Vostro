unit Global; {Глобальное}

interface
    const
        ERR_TOO_MANY_PARAMS = 'Слишком много параметров';
        ERR_BAD_PARAM = 'Плохой параметр: ';
        ERR_LOG_FILE = 'Возникла проблема с файлом журнала';
        ERR_BAD_SECTION = 'Плохой сегмент';
        MSG_DEBUG = 'Отладка = ';
        MSG_LOG = 'Логирование = ';
        MSG_THEME = 'Тема = ';
        MSG_CROSSES = 'Координаты пересечений функций:';
    var
        ini_debug, ini_log: boolean;
        ini_theme: string;
        err_code: integer;
        output_file: text;

implementation

end.

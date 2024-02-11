unit Utils; {Дополнительное}

interface
    function Bool_to_str(bool: boolean): string;


implementation
    uses
        SysUtils; {Стандартное}

    function Bool_to_str(bool: boolean): string;
    begin
        if bool then
            Bool_to_str := 'правда'
        else
            Bool_to_str := 'ложь';
    end;
end.

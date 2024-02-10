unit Utils; {Дополнительное}

interface
function Bool_to_str(bool: boolean): string;


implementation
    function Bool_to_str(bool: boolean): string;
    begin
    if bool then
        Bool_to_str := 'Правда'
    else
        Bool_to_str := 'Ложь';
    end;
end.

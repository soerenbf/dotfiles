function yazi_zed
	set tmp (mktemp -t "yazi-chooser.XXXXX")
	EDITOR=zed yazi $argv --chooser-file=$tmp

	set opened_file (cat -- $tmp | head -n 1)
	if not test -z "$opened_file"  # -z tests if string is empty, 'not' inverts it
        zed -- $opened_file
    end

	rm -f -- $tmp
	exit
end

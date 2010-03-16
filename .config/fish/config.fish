function ee -d "Unpack arbitrary archive files"
        for i in $argv
                switch $i
                        case '**.tar'
                                tar -xf $i
                        case '**.tar.gz' '**.tgz'
                                tar -zxf $i
                        case '**.tar.bz' '**.tar.bz2' '**.tbz' '**.tbz2'
                                 tar -jxf $i
                        case '**.rar'
                                 unrar e $i
                        case '**.zip'
                                 unzip $i
                        case '**'
                                echo File $i is of unknown type
                end
        end
end

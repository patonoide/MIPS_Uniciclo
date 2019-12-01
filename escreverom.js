const fs = require("fs");
let parte = '' ;
let tudo = '';
for (var i = 0; i < 128; i++) {
    console.log(i + "=> '00000000000000000000000000000000',");

    parte = i.toString() + '=> "00000000000000000000000000000000",'
    tudo = tudo + '\n' + parte;
}
console.log(tudo);


    fs.writeFile('memoria.txt', tudo, (err) => {
        // throws an error, you could also catch it here
        if (err) throw err;

        // success case, the file was saved
        console.log('Lyric saved!');
    });

for (var j = 0; j < 128; j++) {
    parte ='  when "0000000" => data <= my_rom('+ i.toString() +  ');'
    tudo = tudo + '\n' + parte;
}

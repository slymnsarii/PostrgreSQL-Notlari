-- SELECT - SIMILAR TO - REGEX(Regular Expressions) --

/*
SIMILAR TO : Daha karmaşık pattern(kalıp) ile sorgulama işlemi için SIMILAR TO kullanılabilir.
Sadece PostgreSQL de kullanılır. Büyük Küçük harf önemlidir

REGEX : Herhangi bir kod, metin içerisinde istenen yazı veya kod parçasının aranıp bulunmasını sağlayan
kendine ait bir söz dizimi olan bir yapıdır.MySQL de(REGEXP_LİKE) olarak kullanılır 
PostgreSQL'de "~ or ~*" karakteri ile kullanılır.
*/

CREATE TABLE kelimeler
(
id int,
kelime VARCHAR(50),
harf_sayisi int
);

    INSERT INTO kelimeler VALUES (1001, 'hot', 3);
    INSERT INTO kelimeler VALUES (1002, 'hat', 3);
    INSERT INTO kelimeler VALUES (1003, 'hit', 3);
    INSERT INTO kelimeler VALUES (1004, 'hbt', 3);
    INSERT INTO kelimeler VALUES (1005, 'hct', 3);
    INSERT INTO kelimeler VALUES (1006, 'adem', 4);
    INSERT INTO kelimeler VALUES (1007, 'selim', 5);
    INSERT INTO kelimeler VALUES (1008, 'yusuf', 5);
    INSERT INTO kelimeler VALUES (1009, 'hip', 3);
    INSERT INTO kelimeler VALUES (1010, 'HOT', 3);
    INSERT INTO kelimeler VALUES (1011, 'hOt', 3);
    INSERT INTO kelimeler VALUES (1012, 'h9t', 3);
    INSERT INTO kelimeler VALUES (1013, 'hoot', 4);
    INSERT INTO kelimeler VALUES (1014, 'haaat', 5);
    INSERT INTO kelimeler VALUES (1015, 'hooooot', 5);
    INSERT INTO kelimeler VALUES (1016, 'booooot', 5);
    INSERT INTO kelimeler VALUES (1017, 'bolooot', 5);
	
select * from kelimeler

--  İçerisinde 'ot' veya 'at' bulunan kelimeleri listeleyiniz
-- Veya işlemi için | karakteri kullanılır

--SIMILAR TO ile
select * from kelimeler WHERE kelime SIMILAR TO '%(at|ot|Ot|oT|At|aT|OT)%'; --buyuk kucuk harf onemli

--LIKE ile
select * from kelimeler WHERE kelime ILIKE '%at%' or kelime ILIKE '%ot%'; 
select * from kelimeler WHERE kelime ~~* '%at%' or kelime ~~* '%ot%'

--REGEX
select * from kelimeler where kelime ~* 'ot' or kelime ~* 'at'

-- 'ho' veya 'hi' ile başlayan kelimeleri listeleyeniz
--SIMILAR TO ile 
select * from kelimeler where kelime similar to 'ho%|hi%'
--LIKE ile
select * from kelimeler where kelime ~~* 'ho%' or kelime ~~* 'hi%'
--REGEX ile
select * from kelimeler where ~* 'h[oi](.*)' --REGEX'de ".(nokta) bir karakteri temsil eder"
--REGEX'de ikinci karakter icin koseli parantez kullanilir. * hepsi anlaminda kullanilir

--Sonu 't' veya 'm' ile bitenleri listeleyeniz
--SIMILAR TO ile
select * from kelimeler where kelime similar to '%t|%m';
--REGEX ile
select * from kelimeler where kelime ~* '.*[tm]$' 
--$ karakteri bitisi gosterir, eger koymazsan mesela kelime hatice olsa bunu da yazdirir yani t'den sonrasi olan
--kelimeleri de yazdirir

--h ile başlayıp t ile biten 3 harfli kelimeleri listeleyeniz
--SIMILAR TO ile
select * from kelimeler where kelime similar to 'h[a-z,A-Z,0-9]t'; --[ikinci karakter]
--LIKE ile
select * from kelimeler where kelime ~~* 'h_t'
--REGEX ile
select * from kelimeler where kelime ~* 'h[a-z,A-Z,0-9]t'

--İlk karakteri 'h', son karakteri 't' ve ikinci karakteri 'a'dan 'e'ye herhangi bir karakter olan 
--“kelime" değerlerini çağırın.
--SIMILAR TO ile
select * from kelimeler where kelime similar to 'h[a-e]%t'
--REGEX ile
select * from kelimeler where kelime ~* 'h[a-e](.*)t'  --ilk harf h, ikinci harf a-e arasi, 
															  --(.*) sonrası ne gelirse gelsin, son harf t

--İlk karakteri 's', 'a' veya 'y' olan "kelime" değerlerini çağırın.
select * from kelimeler where kelime ~ '^[say](.*)' --^ baslangic'i temsil eder

--Son karakteri 'm', 'a' veya 'f' olan "kelime" değerlerini çağırın.
select * from kelimeler where kelime ~ '(.*)[maf]$' --(.*) kullanmasan da olur

-- İlk harfi h, son harfi t olup 2.harfi a veya i olan 3 harfli kelimelerin tüm bilgilerini sorgulayalım.
--SIMILAR TO ile
select * from kelimeler where kelime similar to 'h[a|i]t'
--REGEX ile
select * from kelimeler where kelime ~* '^h[a|i]t$'

--İlk harfi 'b' dan ‘s' ye bir karakter olan ve ikinci harfi herhangi bir karakter olup 
--üçüncü harfi ‘l' olan “kelime" değerlerini çağırın. 
select kelime from kelimeler WHERE kelime ~ '^[b-s].l(.*)'
--^[b-s] ilk harf, .(nokta) herhangi bir karakteri temsil ediyor, l 3.harf, (.*) sonrasi ne olursa olsun

--içerisinde en az 2 adet o o barındıran kelimelerin tüm bilgilerini listeleyiniz.
select kelime from kelimeler WHERE kelime similar to '%[o][o]%' --basinda yada sonunda ne olursa olsun icinde
																--2 tane o o olan
select kelime from kelimeler WHERE kelime similar to '%[o]{2}%' --2.yol --suslu parantez icinde belirttigimiz rakam
								  --bir onceki koseli parantez icinde en az kac tane olmasini istedigimizi belirtir

--içerisinde en az 4 adet oooo barıdıran kelimelerin tüm bilgilerini listeleyiniz.
select kelime from kelimeler WHERE kelime similar to '%[o]{4}%'

--'a', 's' yada 'y' ile başlayan VE 'm' yada 'f' ile biten "kelime" değerlerini çağırın.
select kelime from kelimeler WHERE kelime ~ '^[a|s|y](.*)[m|f]$'
В данном репозитории находится исходный код тестовых сценариев сравнения [Redis](https://redis.io/) и [Tarantool](https://www.tarantool.io/) для [K6](https://k6.io/).   
Для запуска тестов необходимо собрать исполняемый файл К6 с подключенным расширением для работы с Tarantool. Инструкцию, как это сделать, можно найти по [ссылке](https://github.com/tarantool/xk6-tarantool).   
После этого можно запускать тестовые сценарии с помощью команды `k6 run <файл с тестом>`, предварительно указав в файле адрес Redis/Tarantool. Перед запуском тестов для Tarantool нужно подготовить структуру спейса, для этого предназначены скрипты под названием init.lua.   
Для запуска сценария на проверку вторичных индексов потребуется  модуль RediSearch, документацию которого можно найти [здесь](https://redis.io/docs/stack/search/).   
**Пример:**   
Запустим сценарий на проверку быстродействия в режиме key-value для Redis:

    k6 run tarantool-k6-load-test-scenarios/key-value/redis.js
Затем подготовим спейс для Tarantool:

    tarantool tarantool-k6-load-test-scenarios/key-value/init.lua
 После этого запустим тестовый сценарий для Tarantool:

     k6 run tarantool-k6-load-test-scenarios/key-value/tnt.js

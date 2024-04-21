const Redis = require("ioredis");
const sentinel_hosts = process.env.REDIS_SENTINELS.split(",");
let sentinels = []
sentinel_hosts.forEach(function (element, _) {
    console.log(`host: ${element}`);
    let config = element.split(":");
    console.log(`host: ${config[0]} port: ${config[0]}`);
    sentinels.push({
        host: config[0], port: parseInt(config[1])
    });
});
const redis = new Redis({
    sentinels: sentinels,
    name: process.env.CLUSTER_NAME,
    password: process.env.REDIS_PASSWORD,
    // sentinelPassword: process.env.REDIS_PASSWORD, # if sentinel auth enabled
    db: process.env.REDIS_DB_NUMBER
});

const arraySize = 100000;
const randomList = Array.from({ length: arraySize }, (_, i) => i);
randomList.forEach(function (element, index) {
    redis.set(`element${index}`, `${element}`);
});
randomList.forEach(function (_, index) {
    redis.get(`element${index}`, (err, result) => {
        if (err) {
            console.error(err);
        } else {
            console.log(result);
        }
    });
});

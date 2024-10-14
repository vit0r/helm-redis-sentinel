package com.example;

import java.io.IOException;

import org.redisson.Redisson;
import org.redisson.api.RBucket;
import org.redisson.api.RedissonClient;
import org.redisson.config.Config;

public class App {
    public static void main(String[] args) throws IOException {
        Config config = new Config();
        String[] sentinelServes = System.getenv("REDIS_SENTINELS").split(",");
        config.useSentinelServers()
                .setMasterName(System.getenv("MASTER_NAME"))
                .setDatabase(Integer.parseInt(System.getenv("DATABASE")))
                .setSentinelUsername(System.getenv("REDIS_USERNAME"))
                .setSentinelPassword(System.getenv("REDIS_PASSWORD"))
                .setUsername(System.getenv("REDIS_USERNAME"))
                .setPassword(System.getenv("REDIS_PASSWORD"))
                .addSentinelAddress(sentinelServes);
        RedissonClient redisson = Redisson.create(config);
        RBucket<String> bucket = redisson.getBucket("demo");
        bucket.set("Hello");
        System.out.println("value from key demo: " + bucket.get());
    }
}

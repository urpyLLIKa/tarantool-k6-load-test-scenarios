import redis from "k6/experimental/redis";
import exec from "k6/execution";

export const options = {
    discardResponseBodies: true,
    scenarios: {
        test_mem: {
            executor: "constant-vus",
            exec: "set_keys",
            vus: 100,
            duration: "120s",
        },
    },
};
const client = new redis.Client('redis://127.0.0.1:6379');

export function set_keys() {
    client.hset("test:" + exec.vu.idInInstance, "title", "test" + exec.vu
        .iterationInInstance + exec.vu.idInInstance * 100);
}
export function search() {
    let title = "test" + exec.vu.iterationInInstance + exec.vu.idInInstance *
        100
    client.sendCommand(
        "FT.SEARCH",
        "idx:test",
        title,
    );
}
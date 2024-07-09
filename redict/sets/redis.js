import redis from "k6/experimental/redis";
import exec from "k6/execution";

export const options = {
    discardResponseBodies: true,
    scenarios: {
        test: {
            executor: "constant-vus",
            exec: "add",
            vus: 100,
            duration: "120s",
        },
    },
};
const client = new redis.Client('redis://127.0.0.1:6379');

export function add() {
    client.sadd("test" + exec.vu.idInInstance * 1000, (exec.vu
        .iterationInInstance + exec.vu.idInInstance * 100).toString());
}
export function members() {
    client.smembers("test" + exec.vu.idInInstance * 1000);
}
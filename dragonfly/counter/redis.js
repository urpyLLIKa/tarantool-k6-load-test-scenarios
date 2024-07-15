import redis from "k6/experimental/redis";
import exec from "k6/execution";

export const options = {
    discardResponseBodies: true,
    scenarios: {
        test_incr: {
            executor: "constant-vus",
            exec: "incr",
            vus: 50,
            duration: "120s",
        },
        test_decr: {
            executor: "constant-vus",
            exec: "decr",
            vus: 50,
            duration: "120s",
        },
    },
};

const client = new redis.Client('redis://127.0.0.1:6379');

export function incr() {
    client.incr("id" + exec.vu.idInInstance);
}
export function decr() {
    client.decr("id" + exec.vu.idInInstance);
}
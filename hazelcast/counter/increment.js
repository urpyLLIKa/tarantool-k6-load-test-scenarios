import hazelcast from "k6/x/hazelcast";
import exec from "k6/execution";

export const options = {
    discardResponseBodies: true,
    scenarios: {
        test_incr: {
            executor: 'constant-vus',
            exec: 'incr',
            vus: 100,
            duration: '120s',
        },
        test_decr: {
            executor: 'constant-vus',
            exec: 'decr',
            vus: 100,
            duration: '120s',
        },
    },
};

const client = hazelcast.connect(["host:port", "host:port", "host:port"]);

export function incr() {
    hazelcast.incr(client,'aa'+exec.vu.idInInstance);
}
export function decr() {
    hazelcast.decr(client,'aa'+exec.vu.idInInstance);
}
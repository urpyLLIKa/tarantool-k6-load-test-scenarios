import hazelcast from "k6/x/hazelcast";
import exec from "k6/execution";

export const options = {
    discardResponseBodies: true,
    scenarios: {
        test: {
            executor: "constant-vus",
            exec: "set_keys",
            vus: 100,
            duration: "120s",
        },
    },
};


const client = hazelcast.connect(["host:port", "host:port", "host:port"]);

const map = hazelcast.getMap(client, "map_title");

export function set_keys() {
    hazelcast.set(map, exec.vu.iterationInInstance + exec.vu.idInInstance * 100, exec.vu
        .iterationInInstance + exec.vu.idInInstance * 1000);
}
export function get_keys() {
    hzCast.get(map, exec.vu.iterationInInstance + exec.vu.idInInstance * 100);
}

export function del_keys() {
    hazelcast.del(map, exec.vu.iterationInInstance + exec.vu.idInInstance * 100);
}
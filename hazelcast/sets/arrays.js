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

const map = hazelcast.getMultimap(client, "multi_test");

export function set_keys() {
    hazelcast.multimapSet(map, 'test'+exec.vu.idInInstance*1000, exec.vu.iterationInInstance + exec.vu.idInInstance * 100, exec.vu
        .iterationInInstance + exec.vu.idInInstance * 1000);
}
export function get_keys() {
    hazelcast.multimapMembers(map, exec.vu.iterationInInstance + exec.vu.idInInstance * 100);
}

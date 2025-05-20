from mitmproxy import http  # type: ignore


def request(flow: http.HTTPFlow):
    flow.response = http.Response.make(
        200, b"OK", {"Content-Type": "text/plain"}
    )

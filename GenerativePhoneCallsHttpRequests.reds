import RedHttpClient.*

public class HttpRequestSystem extends ScriptableSystem {


    private func StableHordePostRequest(playerMessage: String) {
    let requestDTO = this.CreateTextGenerationRequest(playerMessage);
    let tokens = this.EstimateTokens(requestDTO.prompt);
    let jsonRequest = ToJson(requestDTO);
    
    let callback = HttpCallback.Create(this, n"StableHordePostResponse");
    let headers: array<HttpHeader> = [
        HttpHeader.Create("Content-Type", "application/json"),
        HttpHeader.Create("accept", "application/json"),
        HttpHeader.Create("apikey", GetApiKey()),
        HttpHeader.Create("Client-Agent", "unknown:0:unknown")
    ];
    
    AsyncHttpClient.Post(callback, "https://stablehorde.net/api/v2/generate/text/async", jsonRequest.ToString(), headers);
    ConsoleLog("== API POST Request ==");
    ConsoleLog(s"\(jsonRequest.ToString("\t"))");
    ConsoleLog(s"== Tokens: \(tokens) ==");
    this.ToggleIsGenerating(true);
  }

}
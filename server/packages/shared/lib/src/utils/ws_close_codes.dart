// For more information on Websocket exit codes follow this URL:
// https://github.com/Luka967/websocket-close-codes

enum WsCloseCodes {
  closeNormal(1000, "CLOSE_NORMAL"),
  closeGoingAway(1001, "CLOSE_GOING_AWAY"),
  closeProtocolError(1003, "CLOSE PROTOCOL ERROR"),
  closeUnsupportedPayLoad(1007, "UNSUPPORTED_PAYLOAD"),
  mandatoryExtensionNotFound(1010, "MANDATORY DEPENDENCY NOT FOUND");

  final int closeCode;
  final String closeReason;
  const WsCloseCodes(this.closeCode, this.closeReason);
}

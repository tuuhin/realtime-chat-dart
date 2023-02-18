enum WsCloseCodes {
  closeNormal(1000, "CLOSE_NORMAL"),
  closeGoingAway(1001, "CLOSE_GOING_AWAY"),
  closeProtocolError(1003, "CLOSE PROTOCOL ERROR"),
  closeUnsupportedPayLoad(1007, "UNSUPPORTED_PAYLOAD");

  final int closeCode;
  final String closeReason;
  const WsCloseCodes(this.closeCode, this.closeReason);
}

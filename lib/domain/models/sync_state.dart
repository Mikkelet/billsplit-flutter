enum SyncState {
  synced,
  pending,
  failed;

  static SyncState fromId(int id) {
    if (id == 0) return SyncState.synced;
    if (id == 1) return SyncState.pending;
    return SyncState.failed;
  }
}

import 'package:mobile/pages/selection/gadgetConnection/states/connectionStates.dart';
import 'package:mobile/pages/selection/gadgetConnection/states/idle_state.dart';
import 'package:mobile/pages/selection/gadgetConnection/states/connected_state.dart';
import 'package:mobile/pages/selection/gadgetConnection/states/connecting_state.dart';

class GadgetRegistry {
  static final Map<ConnectState, GadgetUIState> states = {
    ConnectState.idle: const IdleState(),
    ConnectState.connecting: const ConnectingState(),
    ConnectState.connected: const ConnectedState(),
  };
}

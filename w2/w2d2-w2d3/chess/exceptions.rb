class ChessError < ArgumentError; end
class InvalidInputError < ChessError; end
class TurnError < ChessError; end
class NoPieceError < ChessError; end
class InvalidMoveError < ChessError; end
class InvalidCastleError < ChessError; end
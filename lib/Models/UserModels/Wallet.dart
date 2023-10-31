class Wallet {
  late String userId;
  List<PietyCoins>? pietyCoins;
  List<ReferralReward>? referralReward;
}

class PietyCoins {
  String? orderId;
  int? coinsEarned;
}

class ReferralReward {
  String? referUid;
  String? reward;
}
/*
<html>
<head>
<script>
function msg(){
  alert('hello');
}
</script>
</head>
<body>
<center>
<input type='buton'onClick='msg()' value='call function'/>
</body>
</html>*/
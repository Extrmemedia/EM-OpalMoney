class ModelMyWallet {
  String status;
  int earnings;
  int balance;
  int reffered;
  int pending;
  int rejected;
  int completed;

  ModelMyWallet(
      {this.status,
        this.earnings,
        this.balance,
        this.reffered,
        this.pending,
        this.rejected,
        this.completed});

  ModelMyWallet.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    earnings = json['earnings'];
    balance = json['balance'];
    reffered = json['reffered'];
    pending = json['pending'];
    rejected = json['rejected'];
    completed = json['completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['earnings'] = this.earnings;
    data['balance'] = this.balance;
    data['reffered'] = this.reffered;
    data['pending'] = this.pending;
    data['rejected'] = this.rejected;
    data['completed'] = this.completed;
    return data;
  }
}
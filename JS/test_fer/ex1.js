class Interval {
    constructor(initial, final) {
      this.initial = initial;
      this.final = final;
    }
  }

function addInterval(interval) {
    if (!Number.isInteger(interval.initial) || !Number.isInteger(interval.final)) {
        return
    }

    var sum = 0

    for (var i = interval.initial; i <= interval.final; i++) {
        if (i % 2 != 0) {
            sum = sum + i;
        }
    }
    return sum;
}

function printIntervalSum(index, sum) {
    if (Number.isInteger(sum)) {
        console.log("Intervalo " + index + ": " + sum);
    } else {
        console.log("");
    }
}

function main() {
    let intervals = [new Interval(2), new Interval(1,5), new Interval(3,5)]
    for (i = 0; i < intervals.length; i++) {
        interval = intervals[i]
        res = addInterval(interval);
        printIntervalSum(i, res);
    }
}

main();
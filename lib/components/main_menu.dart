import 'package:flutter/material.dart';

class MainMenu extends StatefulWidget {
  final TabController tabController;

  const MainMenu(this.tabController);

  @override
  _PortfolioMenuState createState() => _PortfolioMenuState();
}

class _PortfolioMenuState extends State<MainMenu>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  AnimationController _controller;
  Animation _animation0;
  Animation _animation1;
  Animation _animation2;

  @override
  void initState() {
    super.initState();
    _tabController = widget.tabController;
    _tabController.addListener(() {
      setState(() {});
    });
    _controller = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    _animation0 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.0,
          0.5,
          curve: Curves.ease,
        )));
    _animation1 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.25,
          0.75,
          curve: Curves.ease,
        )));
    _animation2 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.50,
          1.0,
          curve: Curves.ease,
        )));
  }

  void _animate() {
    if (_controller.status == AnimationStatus.completed)
      _controller.reverse();
    else if (_controller.status == AnimationStatus.dismissed)
      _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) => Row(
        children: [
          IconButton(
            onPressed: () => _animate(),
            icon: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: _controller,
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                AnimatedItem(
                  onTap: () {
                    _tabController.animateTo(0);
                  },
                  animation: _animation0,
                  label: "about",
                  selected: _tabController.index == 0,
                ),
                AnimatedItem(
                  onTap: () {
                    _tabController.animateTo(1);
                  },
                  animation: _animation1,
                  label: "projects",
                  selected: _tabController.index == 1,
                ),
                AnimatedItem(
                  onTap: () {
                    _tabController.animateTo(2);
                  },
                  animation: _animation2,
                  label: "services",
                  selected: _tabController.index == 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedItem extends StatelessWidget {
  final Animation animation;
  final String label;
  final Function onTap;
  final bool selected;

  const AnimatedItem({
    this.animation,
    this.label,
    this.onTap,
    this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: animation.value,
      child: Transform(
        transform: Matrix4.translationValues(
          50 - 50 * animation.value,
          0,
          0,
        ),
        child: FlatButton(
          onPressed: onTap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          color: selected ? Colors.grey.withAlpha(0x22) : Colors.transparent,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
            ),
          ),
        ),
      ),
    );
  }
}

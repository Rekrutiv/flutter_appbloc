import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_concepts/generated/l10n.dart';
import 'package:flutter_bloc_concepts/logic/cubit/counter_cubit.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title, this.color}) : super(key: key);

  final String title;
  final Color color;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> homeScreenKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScreenKey,
      appBar: AppBar(
        backgroundColor: widget.color,
        title: Text(S.of(context).app_bar_title),
      ),
      body: Center(
        child: BlocConsumer<CounterCubit, CounterState>(
            listener: (context, state) {
          if (state.wasIncremented == true) {
            homeScreenKey.currentState.showSnackBar(
              SnackBar(
                content: Text('Incremented size!'),
                duration: Duration(milliseconds: 300),
              ),
            );
          } else if (state.wasIncremented == false) {
            homeScreenKey.currentState.showSnackBar(
              SnackBar(
                content: Text('Decremented size!'),
                duration: Duration(milliseconds: 300),
              ),
            );
          }
        }, builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MaterialButton(
                color: Colors.redAccent,
                splashColor: Colors.yellow,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                child: Text(
                  'Go to Second Screen',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    '/second',
                    arguments: homeScreenKey,
                  );
                },
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    heroTag: Text('${widget.title}'),
                    onPressed: () {
                      BlocProvider.of<CounterCubit>(context).decrement();
                      // context.bloc<CounterCubit>().decrement();
                    },
                    tooltip: 'Decrement',
                    child: Icon(Icons.remove),
                  ),
                  AnimatedContainer(
                    duration: Duration(seconds: 2),
                    curve: Curves.bounceOut,
                    height: 100 + state.counterValue.toDouble(),
                    width: 100 + state.counterValue.toDouble(),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      shape: BoxShape.circle,
                    ),
                    child: Center(child: Text(S.of(context).app_bar_title)),
                  ),
                  FloatingActionButton(
                    heroTag: Text('${widget.title} 2nd'),
                    onPressed: () {
                      BlocProvider.of<CounterCubit>(context).increment();
                      //context.bloc<CounterCubit>().increment();
                    },
                    tooltip: 'Increment',
                    child: Icon(Icons.add),
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              MaterialButton(
                color: Colors.greenAccent,
                splashColor: Colors.yellow,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                child: Text(
                  'Go to First Screen',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    '/home',
                  );
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}

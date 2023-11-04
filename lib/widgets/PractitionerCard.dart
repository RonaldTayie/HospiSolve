import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PractionerCard extends StatefulWidget {
  const PractionerCard({super.key});

  @override
  State<PractionerCard> createState() => _PractionerCardState();
}

class _PractionerCardState extends State<PractionerCard> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 0,
      child: Card(
        color: Theme.of(context).cardTheme.surfaceTintColor,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 100,
                height: 100,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.white,
                    style: BorderStyle.solid,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(55)),
                    child: SvgPicture.asset(
                      'assets/images/undraw_female_avatar_efig.svg',
                      semanticsLabel: "",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Title. Initial Surname",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Divider(height: 20),
                    Text(
                      "Doctors basic information",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Divider(height: 10),
                    Text(
                      "Ward : ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      border: Border.all(
                        color: Colors.white,
                        style: BorderStyle.solid,
                        width: 2,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(25.0),
                      ),
                    ),
                    child: const Center(
                      child: Icon(Icons.check),
                    ),
                  ),
                  const Chip(
                    padding: EdgeInsets.all(2.0),
                    side: BorderSide.none,
                    label: Text(
                      "Availability",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

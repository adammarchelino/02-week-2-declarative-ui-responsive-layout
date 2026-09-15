import 'package:flutter/material.dart';

class PraktikumSession {
  final String subject;
  final String time;
  final String room;
  final String status;
  final String description;
  final IconData icon;
  final Color statusColor;
  final Color messageColor;

  const PraktikumSession({
    required this.subject,
    required this.time,
    required this.room,
    required this.status,
    required this.description,
    required this.icon,
    required this.statusColor,
    required this.messageColor,
  });

  static const List<PraktikumSession> today = [
    PraktikumSession(
      subject: 'Mobile Programming',
      time: '08.00 - 10.00',
      room: 'Lab 1',
      status: 'Berlangsung',
      description: 'Sedang digunakan\noleh praktikan',
      icon: Icons.groups_rounded,
      statusColor: Color(0xFF168BD1),
      messageColor: Color(0xFFDCEFFD),
    ),
    PraktikumSession(
      subject: 'Rekayasa Perangkat Lunak',
      time: '10.00 - 12.00',
      room: 'Lab 2',
      status: 'Akan datang',
      description: 'Sesi akan dimulai\nsebentar lagi',
      icon: Icons.access_time_rounded,
      statusColor: Color(0xFFFFD98A),
      messageColor: Color(0xFFFFF5DF),
    ),
    PraktikumSession(
      subject: 'Basis Data',
      time: '13.00 - 15.00',
      room: 'Lab 3',
      status: 'Selesai',
      description: 'Sesi telah selesai',
      icon: Icons.check_circle_rounded,
      statusColor: Color(0xFFE3E7EB),
      messageColor: Color(0xFFE9EEF2),
    ),
  ];
}

class RuangPraktikum extends StatefulWidget {
  const RuangPraktikum({super.key});

  @override
  State<RuangPraktikum> createState() => _RuangPraktikumState();
}

class _RuangPraktikumState extends State<RuangPraktikum> {
  @override
  Widget build(BuildContext context) {
    final baseTheme = Theme.of(context);

    return Theme(
      data: baseTheme.copyWith(
        textTheme: baseTheme.textTheme.apply(
          fontFamily: 'SF Pro Display',
          fontFamilyFallback: const [
            'SF Pro Display',
            'Helvetica Neue',
            'Arial',
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFFAFCFE),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth >= 700;

              return ListView(
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
                children: [
                  const Text(
                    'Ruang Praktikum Hari Ini',
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontFamilyFallback: [
                        'SF Pro Display',
                        'Helvetica Neue',
                        'Arial',
                      ],
                      color: Color(0xFF111827),
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Wrap(
                    spacing: 12,
                    runSpacing: 10,
                    children: [
                      _SummaryPill(
                        icon: Icons.calendar_month_rounded,
                        label: '3 sesi',
                        backgroundColor: Color(0xFFE1F1FC),
                        foregroundColor: Color(0xFF0F6FA8),
                      ),
                      _SummaryPill(
                        icon: Icons.meeting_room_rounded,
                        label: '1 ruang tersedia',
                        backgroundColor: Color(0xFFE0F5EB),
                        foregroundColor: Color(0xFF237A58),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  if (isDesktop)
                    GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      mainAxisExtent: 230,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        ...PraktikumSession.today.map(
                          (session) => _SessionCard(session: session),
                        ),
                        _buildAvailableRoomCard(),
                      ],
                    )
                  else
                    _buildMobileContent(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMobileContent() {
    return _buildSessionColumn();
  }

  Widget _buildSessionColumn() {
    return Column(
      children: [
        ...PraktikumSession.today.map(
          (session) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: _SessionCard(session: session),
          ),
        ),
      ],
    );
  }

  Widget _buildAvailableRoomCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FAF5),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFD4EEE0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Lab 2',
                style: TextStyle(
                  color: Color(0xFF17213A),
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF3AA477),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Tersedia',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Row(
            children: [
              Icon(
                Icons.meeting_room_rounded,
                size: 22,
                color: Color(0xFF475569),
              ),
              SizedBox(width: 12),
              Text(
                'Ruang tersedia\ndi luar jadwal sesi',
                style: TextStyle(
                  color: Color(0xFF475569),
                  fontSize: 15,
                  height: 1.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFD9F2E5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.meeting_room_rounded,
                  color: Color(0xFF237A58),
                  size: 24,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Siap digunakan\nuntuk praktikum lain',
                    style: TextStyle(
                      color: Color(0xFF285E49),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryPill extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color backgroundColor;
  final Color foregroundColor;

  const _SummaryPill({
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 18,
            color: foregroundColor,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: foregroundColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _SessionCard extends StatelessWidget {
  final PraktikumSession session;

  const _SessionCard({
    required this.session,
  });

  Color get statusTextColor {
    if (session.status == 'Akan datang') {
      return const Color(0xFF8A5A00);
    }

    if (session.status == 'Selesai') {
      return const Color(0xFF4B5563);
    }

    return Colors.white;
  }

  Color get detailStatusTextColor {
    if (session.status == 'Akan datang') {
      return const Color(0xFF8A5A00);
    }

    if (session.status == 'Selesai') {
      return const Color(0xFF4B5563);
    }

    return const Color(0xFF168BD1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(
          color: Color(0xFFE2E8F0),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _showSessionDetails(context),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      session.subject,
                      style: const TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontFamilyFallback: [
                          'SF Pro Display',
                          'Helvetica Neue',
                          'Arial',
                        ],
                        color: Color(0xFF17213A),
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: session.statusColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      session.status,
                      style: TextStyle(
                        color: statusTextColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              _SessionInfoRow(
                icon: Icons.access_time_rounded,
                text: session.time,
              ),
              const SizedBox(height: 8),
              _SessionInfoRow(
                icon: Icons.location_on_rounded,
                text: session.room,
              ),
              const SizedBox(height: 14),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: session.messageColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      session.icon,
                      color: const Color(0xFF28445F),
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        session.description,
                        style: const TextStyle(
                          color: Color(0xFF28445F),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSessionDetails(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  session.subject,
                  style: const TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF17213A),
                  ),
                ),
                const SizedBox(height: 16),
                _SessionInfoRow(
                  icon: Icons.access_time_rounded,
                  text: session.time,
                ),
                const SizedBox(height: 10),
                _SessionInfoRow(
                  icon: Icons.location_on_rounded,
                  text: session.room,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text(
                      'Status: ',
                      style: TextStyle(
                        color: Color(0xFF475569),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      session.status,
                      style: TextStyle(
                        color: detailStatusTextColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: session.messageColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        session.icon,
                        color: const Color(0xFF28445F),
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          session.description,
                          style: const TextStyle(
                            color: Color(0xFF28445F),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Tutup'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SessionInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _SessionInfoRow({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 21,
          color: const Color(0xFF475569),
        ),
        const SizedBox(width: 12),
        Text(
          text,
          style: const TextStyle(
            color: Color(0xFF475569),
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

#include "timer.hpp"

// todo split timeout and display
// todo check 000000
// sound

Timer::Timer(QObject *parent) :
    QObject(parent),
    m_numbers(""),
    m_timer(new QTime()),
    m_resultRunTimer("00:00:00"),
    m_seconds(0),
    m_maxLimitSecond(0)
{
    m_timer->setHMS(0, 0, 0, 0);
    m_tim = new QTimer();

    QObject::connect(m_tim, &QTimer::timeout, [=]()
    {
        emit triggerTimer();
    });
}

Timer::~Timer()
{
}

void Timer::registerMe(const QString &aText)
{
    qmlRegisterType<Timer>(aText.toLatin1(), 1, 0, "ModuleTimer");
}

void Timer::timerEvent(QTimerEvent *event)
{
    Q_UNUSED(event);
    emit changeProcent();
}

int Timer::maxRound()
{
    return (m_maxLimitSecond);
}

QString Timer::display()
{

    if (!m_isRun)
        return m_result;
    return m_resultRunTimer;
}

int32_t Timer::seconds()
{
    return (m_seconds);
}

void Timer::setSeconds(int32_t aSeconds)
{
    if (aSeconds >= 0)
        m_seconds = aSeconds;
}

void Timer::setDisplay(const QString &aText)
{
    m_timer->setHMS(0, 0, 0);

    if (m_numbers.length() < 6)
        m_numbers = m_numbers + aText;

    if (!m_isRun)
    {
        m_result = calculateTime(m_numbers);
    }
    else
    {
        m_resultRunTimer = (m_timer->toString("hh:mm:ss"));
    }
}

void Timer::remove()
{
    m_numbers = m_numbers.remove(m_numbers.length() - 1, m_numbers.length());
    setDisplayTime(m_numbers);

    emit changeDisplay();
}

void Timer::start()
{
    int32_t res = calculateSec(m_numbers);
    m_result = "0";

    if (res == 0 || m_isRun)
        return ;

    *m_timer = m_timer->addSecs(res);
    m_maxLimitSecond = (QTime(0, 0, 0).secsTo(*m_timer));
    // startTimer(1000);
    m_tim->start(1000);

    m_isRun = true;
}

void Timer::stop()
{
    qDebug() << "Stop";
    m_numbers.clear();
    m_timer->setHMS(0, 0, 0);
    m_isRun = false;
    m_result = "00:00:00";
    m_tim->stop();
    emit changeDisplay();
}

void Timer::pause()
{
    if (m_isRun)
    {
        m_tim->blockSignals(true);
        m_isRun = false;
    }
    else
    {
        m_tim->blockSignals(false);
        m_isRun = true;
    }
}

int32_t Timer::calculateSec(const QString &aTime)
{
    int32_t nSize = aTime.length();
    QString sec;
    QString min;
    QString hours;
    int32_t result;

    switch (nSize)
    {
    case 1:
        result = aTime.toInt();
        break;
        // 2 3456
    case 2:
        result = aTime.toInt();
        break;
    case 3:
        sec = aTime.right(2);
        min = aTime.at(0);
        result = (min.toInt() * 60) + sec.toInt();

        break;
    case 4:
        sec = aTime.right(2);
        min = aTime.left(2);
        result = (min.toInt() * 60) + sec.toInt();

        break;
    case 5:
        sec = aTime.right(2);
        min = aTime.mid(1, 2);
        hours = aTime.at(0);

        result = (hours.toInt() * 60 * 60) + min.toInt() + 60 + sec.toInt();
        break;
    case 6:
        sec = aTime.right(2);
        min = aTime.mid(2, 2);
        hours = aTime.left(2);

        result = (hours.toInt() * 60 * 60) + min.toInt() + 60 + sec.toInt();
        break;
    default:
        return {};
    }

    if (checked() && m_isRun)
    {
        m_isRun = false;
        m_timer->setHMS(0, 0, 0);
        m_numbers.clear();
    }

    return (result);
}

QString Timer::calculateTime(const QString &aNum)
{
    QString sec;
    QString min;
    QString hours;
    QString result;

    switch (aNum.length())
    {
    case 1:
              sec = aNum.right(1);
              result = "00:00:0" + aNum;
              break;
    case 2:
              sec = aNum.right(2);
              result = "00:00:" + aNum;
              break;
    case 3:
              sec = aNum.right(2);
              min = aNum.at(0);
              result = "00:0" + min + ":" + sec;
              break;
    case 4:
              sec = aNum.right(2);
              min = aNum.left(2);
              result = "00:" + min + ":" + sec;
              break;
    case 5:
              sec = aNum.right(2);
              min = aNum.mid(1, 2);
              hours = aNum.at(0);
              result = "0" + hours + ":" + min + ":" + sec;
              break;
    case 6:
              sec = aNum.right(2);
              min = aNum.mid(2, 2);
              hours = aNum.left(2);
              result = hours + ":" + min + ":" + sec;
              break;
    default:
              result = "00:00:00";
    }

    return (result);
}

void Timer::setDisplayTime(const QString &aText)
{
    m_result = calculateTime(aText);
}


int Timer::procentRound()
{
    // qDebug() << "FILL ROUND: " <<
    //             "max: " << maxRound() <<
    //             "\nsec: " << seconds() <<
    //             "\nresult: " << (m_maxLimitSecond * seconds() / 100);
    return seconds();
}

void Timer::timeout()
{
    if (m_isRun)
    {
        setSeconds(QTime(0, 0, 0).secsTo(*m_timer));
        if (checked())
        {
            m_tim->stop();
            QSound::play("qrc:/trimed.wav");
            return ;
        }

        auto res = QTime(0, 0, 0).secsTo(*m_timer);
        res -= 1;
        m_timer->setHMS(0, 0, 0);
        *m_timer = m_timer->addSecs(res);
        m_resultRunTimer = m_timer->toString("hh:mm:ss");
    }
}

bool Timer::isCheckedButton()
{
    int32_t res = calculateSec(m_numbers);

    qDebug() << "n: " << res;

    if (res == 0)
        return false;
    return true;
}

bool Timer::checked()
{
    if (QTime(0, 0, 0).secsTo(*m_timer) == 0)
        return (true);
    return (false);
}


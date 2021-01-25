#include "stopwatch.hpp"
#include <QQmlEngine>

StopWatch::StopWatch(QObject *parent) :
    QObject(parent),
    m_timer(new QTime()),
    m_isRun(false)
{
    startTimer(10);
    m_timer->setHMS(0, 0, 0);
}

StopWatch::~StopWatch()
{
}

void StopWatch::registerMe(const QString &aNameModule)
{
    qmlRegisterType<StopWatch>(aNameModule.toLatin1(), 1, 0, "ModuleStopWatch");
}

void StopWatch::timerEvent(QTimerEvent *event)
{
    Q_UNUSED(event);
    emit triggerTime("test");
}

void StopWatch::start()
{
    m_isRun = true;
}

void StopWatch::stop()
{
    m_isRun = false;
}

void StopWatch::reset()
{
    m_timer->setHMS(0, 0, 0);
}

QString StopWatch::display()
{
    if (m_isRun)
        timeout();

    return (m_timer->toString("mm:ss:zzz"));
}

void StopWatch::setDisplay(QString &aText)
{
    Q_UNUSED(aText);
}

void StopWatch::timeout()
{
    if (m_isRun)
        *m_timer = m_timer->addMSecs(10);
}

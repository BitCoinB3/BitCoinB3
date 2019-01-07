// Copyright (c) 2011-2014 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef BITCOINB3_QT_BITCOINB3ADDRESSVALIDATOR_H
#define BITCOINB3_QT_BITCOINB3ADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class BitcoinB3AddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit BitcoinB3AddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

/** BitcoinB3 address widget validator, checks for a valid bitcoinb3 address.
 */
class BitcoinB3AddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit BitcoinB3AddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

#endif // BITCOINB3_QT_BITCOINB3ADDRESSVALIDATOR_H
